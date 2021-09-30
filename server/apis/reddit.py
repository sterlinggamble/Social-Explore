import requests
from apis.keys import REDDIT_CLIENT_KEY, REDDIT_SECRET, PASSWORD, USERNAME


class RedditAPI():
    def __init__(self):
        client_id = REDDIT_CLIENT_KEY
        client_secret = REDDIT_SECRET

        auth = requests.auth.HTTPBasicAuth(client_id, client_secret)

        data = {
            'grant_type': 'password',
            'username': USERNAME,
            'password': PASSWORD
        }

        self.headers = {'User-Agent': 'MyAPI/0.0.1'}

        res = requests.post('https://www.reddit.com/api/v1/access_token',
                            auth=auth, data=data, headers=self.headers)

        access_token = res.json()['access_token']
        self.headers['Authorization'] = 'Bearer {}'.format(access_token)

    def post_data(self, post_ids):
        string_post_ids = ""
        for id in post_ids:
            string_post_ids += id + ","

        search_url = "https://oauth.reddit.com/by_id/" + string_post_ids[:-1]

        res = requests.get(search_url, headers=self.headers)
        return res.json()['data']['children']

    def user_posts(self, username):
        search_url = 'https://oauth.reddit.com/user/{}/submitted'.format(
            username)

        res = requests.get(search_url, headers=self.headers)

        return res.json()['data']['children']

    def subreddit_posts(self, subreddit):
        search_url = 'https://oauth.reddit.com/r/{}/top'.format(subreddit)

        res = requests.get(search_url, headers=self.headers)

        return res.json()['data']['children']
