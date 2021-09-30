import requests
import base64
from apis.keys import TWITTER_CLIENT_KEY, TWITTER_SECRET_KEY


class TwitterAPI():
    def __init__(self):
        client_key = TWITTER_CLIENT_KEY
        client_secret = TWITTER_SECRET_KEY

        key_secret = '{}:{}'.format(client_key, client_secret).encode('ascii')
        b64_encoded_key = base64.b64encode(key_secret)
        b64_encoded_key = b64_encoded_key.decode('ascii')

        self.base_url = 'https://api.twitter.com/'
        auth_url = '{}oauth2/token'.format(self.base_url)

        auth_headers = {
            'Authorization': 'Basic {}'.format(b64_encoded_key),
            'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
        }

        auth_data = {
            'grant_type': 'client_credentials'
        }

        auth_resp = requests.post(
            auth_url, headers=auth_headers, data=auth_data)
        self.access_token = auth_resp.json()['access_token']

        self.search_headers = {
            'Authorization': 'Bearer {}'.format(self.access_token)
        }

    # Returns a list of retweeters for a specified tweet
    def retweeters(self, id, count):
        search_params = {
            'id': id,
            'count': count
        }

        search_url = '{}1.1/statuses/retweeters/ids.json'.format(
            self.base_url)

        search_resp = requests.get(
            search_url, headers=self.search_headers, params=search_params)

        search_data = search_resp.json()

        ids = search_data['ids']
        return ids

    # Returns a list of favorited tweets for a specified user
    def favorite_list(self, user_id, count=20):
        search_params = {
            'user_id': user_id,
            'count': count
        }

        search_url = '{}1.1/favorites/list.json'.format(
            self.base_url)

        search_resp = requests.get(
            search_url, headers=self.search_headers, params=search_params)

        search_data = search_resp.json()

        return search_data

    def user_timeline(self, user_id, count=20):
        search_params = {
            'user_id': user_id,
            'count': count
        }

        search_url = '{}1.1/statuses/user_timeline.json'.format(
            self.base_url)

        search_resp = requests.get(
            search_url, headers=self.search_headers, params=search_params)

        search_data = search_resp.json()

        return search_data

    def tweet_info(self, id):
        search_params = {
            'id': id
        }

        search_url = '{}1.1/statuses/show.json'.format(self.base_url)

        search_resp = requests.get(
            search_url, headers=self.search_headers, params=search_params)

        search_data = search_resp.json()

        return search_data
