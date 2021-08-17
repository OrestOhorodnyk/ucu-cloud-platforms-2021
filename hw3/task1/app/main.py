from tweepy import (
    Stream,
    OAuthHandler
)
from tweetListener import TweetListener
from keys import (
    API_KEY,
    API_SECRET_KEY,
    ACCESS_TOKEN,
    ACCESS_TOKEN_SECRET
)


class TweetStream:
    def __init__(self, auth, listener):
        self.stream = Stream(auth=auth, listener=listener)

    def start(self, keyword_list):
        self.stream.filter(track=keyword_list)


if __name__ == "__main__":
    listener = TweetListener()
    auth = OAuthHandler(consumer_key=API_KEY, consumer_secret=API_SECRET_KEY)
    auth.set_access_token(key=ACCESS_TOKEN, secret=ACCESS_TOKEN_SECRET)

    stream = TweetStream(auth=auth, listener=listener)
    stream.start(['covid'])
