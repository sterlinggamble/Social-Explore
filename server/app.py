from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from apis.reddit import RedditAPI
from apis.twitter import TwitterAPI
from recommender import twitter_rec, reddit_rec

app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///social-explore.db"
db = SQLAlchemy(app)

twitter_api = TwitterAPI()
reddit_api = RedditAPI()


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String, unique=True, nullable=False)


class Post(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    post_host_id = db.Column(db.Integer)
    host = db.Column(db.String, nullable=False)  # (twitter or reddit)
    content_score = db.Column(db.Float)
    collab_score = db.Column(db.Float)
    trained = db.Column(db.Boolean)
    topic_id = db.Column(db.Integer, db.ForeignKey('topic.id'))


class Topic(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    user_id = db.Column(db.Integer, unique=True, nullable=False)
    posts = db.relationship('Post', backref='topic')


db.create_all()
db.session.commit()


@app.route('/register', methods=['POST'])
def register():
    db.session.add(User(email=request.json['email']))
    db.session.commit()

    user = User.query.filter_by(email=request.json['email']).first()

    return {"id": user.id, "email": user.email}


@app.route('/login', methods=['POST'])
def login():
    user = User.query.filter_by(email=request.json['email']).first()
    if user:
        return {"id": user.id, "email": user.email}
    return 'User Does Not Exist'


@app.route('/create_topic', methods=['POST'])
def create_topic():
    topic = Topic(name=request.json['name'], user_id=request.json['user_id'])

    # add posts to topic and database
    for id in request.json['twitter_posts']:
        post = Post(post_host_id=id, host='twitter')
        topic.posts.append(post)
        db.session.add(post)

    for id in request.json['reddit_posts']:
        post = Post(post_host_id=id, host='reddit')
        topic.posts.append(post)
        db.session.add(post)

    db.session.add(topic)
    db.session.commit()

    # return topic.id
    return "Topic Created"


@app.route('/topic', methods=['GET'])
def topic():
    topic = Topic.query.filter_by(user_id=request.json['user_id']).first()
    return {
        "name": topic.name,
        "posts": [
            {
                'id': p.id,
                'post_id': p.post_host_id,
                'host': p.host
            }
            for p in topic.posts
        ]
    }


@app.route('/check_url', methods=['GET'])
# returns a full post's data given a valid url
def check_url():
    url = request.json['url']
    if "twitter.com" in url:
        end = url.split('/')[-1]
        # url from share button adds '?s=20' at the end
        post_id = end.split('?')[0]
        return twitter_api.tweet_info(post_id)
    elif "reddit.com" in url:
        split_url = url.split('/')
        post_id = "t3_" + split_url[len(split_url)-3]
        return reddit_api.post_data([post_id])[0]

    return "Link Not Valid"


@app.route('/like', methods=['POST'])
def like():
    post = Post(post_host_id=request.json['id'], host=request.json['host'])
    db.session.add(post)
    db.session.commit()
    return "Post Liked"


@app.route('/recommendations', methods=['GET'])
def recommendations():
    # get all topics from user
    topics = Topic.query.filter_by(user_id=request.json['user_id']).all()
    results = []
    for topic in topics:
        # send posts from each topic to recommender
        for post in topic.posts:
            if post.host == "twitter":
                tweets = twitter_rec([str(post.post_host_id)], twitter_api)
                for tweet in tweets:
                    tweet['topic'] = topic.name

                tweets.sort(key=lambda p:
                            p['scores']['content'] + p['scores']['collab'],
                            reverse=True)

                if len(tweets) > 10:
                    results += tweets[:10]
                results += tweets

            elif post.host == "reddit":
                posts = reddit_rec([post.post_host_id], reddit_api)
                for post in posts:
                    post['topic'] = topic.name
                results += posts

    return jsonify(results)


if __name__ == 'main':
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
