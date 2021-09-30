import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel, cosine_similarity


class Tweet:
    def __init__(self, tweet):
        self.data = tweet
        self.id = tweet['id']
        self.author = tweet['user']['id']
        self.text = tweet['text']
        self.sim_score = 0  # content-based similarity score
        self.collab_score = 0  # user-based collaborative score
        self.overall_score = 0  # DNN final score


def twitter_rec(input_tweets, api):
    tweets = {}
    interactors = {}
    authors = set()

    # fetch data from each input tweet
    for tweet_id in input_tweets:
        tweet_json = api.tweet_info(tweet_id)
        tweet = Tweet(tweet_json)
        tweets[tweet.id] = tweet

        # add author
        authors.add(tweet.author)

        # add retweeters and update interactions
        retweeters = api.retweeters(tweet_id, 20)
        for retweeter in retweeters:
            if retweeter in interactors:
                interactors[retweeter].add(tweet.id)
            else:
                interactors[retweeter] = {tweet.id}

    # for each author get their /user_timeline
    for author in authors:
        timeline_tweets = api.user_timeline(author)

        # update interactions w/ author's interactions
        if author in interactors:
            interactors[author].update([tweet['id']
                                       for tweet in timeline_tweets])
        else:
            interactors[author] = set([tweet['id']
                                      for tweet in timeline_tweets])

        # add author's tweets
        for tweet in timeline_tweets:
            if tweet['id'] not in tweets:
                tweets[tweet['id']] = Tweet(tweet)

    # for each interactor (retweeters and authors) get their /favorites_list
    for user in interactors:
        favorited_tweets = api.favorite_list(user)
        # interactors[user].update([tweet['id'] for tweet in favorited_tweets])

        for tweet in favorited_tweets:
            if not isinstance(tweet, str):
                interactors[user].add(tweet['id'])
                tweets[tweet['id']] = Tweet(tweet)

    # Content Based filtering
    content_df = pd.DataFrame()
    content_df['tweet_id'] = [id for id in tweets]
    content_df['text'] = [tweet.text for id, tweet in tweets.items()]

    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(content_df['text'])

    # compute consine similarity matrix
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)

    for tweet in input_tweets:
        # get the index of the input tweet
        index = content_df[content_df['tweet_id'] == int(tweet)].index.item()
        scores = list(enumerate(cosine_sim[index]))
        # get scores the pairwsie similarity scores of all movies with that
        # input tweet
        for score in scores:
            tweet_id = content_df.loc[score[0]]['tweet_id']
            # update similairty score
            tweets[tweet_id].sim_score = max(
                score[1], tweets[tweet_id].sim_score)

    # # Collaborative Filtering

    # interaction_df = pd.DataFrame()

    # # initialize dataframe with columns representing tweet ids with enough
    # # rows for each user
    # for id in tweets:
    #     interaction_df[id] = [0] * len(interactors)

    # # add interactions
    # for i, user in enumerate(interactors):
    #     interaction_df.loc[i, interactors[user]] = 1

    # r_matrix_dummy = interaction_df.copy()
    # cosine_sim = cosine_similarity(r_matrix_dummy, r_matrix_dummy)
    # cosine_sim = pd.DataFrame(
    #     cosine_sim, index=interaction_df.index, columns=interaction_df.index)

    # # calculate the cosine similairty weight mean for each tweet
    # for tweet_id in interaction_df:
    #     # get similairty scores for the last user
    #     sim_scores = cosine_sim[len(interactors)]
    #     m_ratings = interaction_df[tweet_id]
    #     wmean_rating = np.dot(sim_scores, m_ratings) / sim_scores.sum()
    #     tweets[tweet_id].collab_score = wmean_rating

    results = []
    # add scoring data to each tweet
    for tweet_id in tweets:
        tweet = tweets[tweet_id]
        # only add tweets with any relevance (total score above 0)
        if tweet.sim_score + tweet.collab_score > 0:
            data = tweet.data
            data['scores'] = {
                'content': tweets[tweet_id].sim_score,
                'collab': tweets[tweet_id].collab_score
            }
            results.append(data)

    return results


def reddit_rec():
    return None
