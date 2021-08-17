from tweepy import StreamListener
from publisher import Publisher

PROJECT_ID = "terraform-321413"
TOPIC_ID = "tweet-terraform-321413"


class TweetListener(StreamListener):

    def on_data(self, raw_data):
        self.process_data(raw_data)
        return True

    def process_data(self, raw_data):
        print(type(raw_data))
        print(raw_data)
        publisher = Publisher(project_id=PROJECT_ID, topic_id=TOPIC_ID)
        publisher.send_message(raw_data)

    def on_error(self, status_code):
        if status_code == 420:
            return False
