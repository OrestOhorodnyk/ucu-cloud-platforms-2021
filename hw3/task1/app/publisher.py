"""Publishes multiple messages to a Pub/Sub topic with an error handler."""
from concurrent import futures
from google.cloud import pubsub_v1


class Publisher:

    def __init__(self, project_id, topic_id):
        publisher = pubsub_v1.PublisherClient()
        self.publisher = pubsub_v1.PublisherClient()
        self.topic_path = publisher.topic_path(project_id, topic_id)

    def get_callback(self, publish_future, data):
        def callback(publish_future):
            try:
                # Wait 60 seconds for the publish call to succeed.
                print(publish_future.result(timeout=60))
            except futures.TimeoutError:
                print(f"Publishing {data} timed out.")

        return callback

    def send_message(self, data):
        publish_futures = []
        publish_future = self.publisher.publish(self.topic_path, data.encode("utf-8"))
        publish_future.add_done_callback(self.get_callback(publish_future, data))
        publish_futures.append(publish_future)
        print(f"Published messages with error handler to {self.topic_path}.")
