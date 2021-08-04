import json
import os
import time

from flask import escape
from google.cloud import storage


def store_to_file(request):
    bucket_name = os.environ.get('BUCKET_NAME', 'Specified environment variable is not set.')
    request_json = request.get_json(silent=True)
    destination_file_name = str(time.time())
    if request_json:
        content = json.dumps(request_json)
        upload_blob(bucket_name, destination_file_name, content)
    else:
        return '<h1 style="margin:20px auto;width:800px;"Required parameter is missing {}!</h1>' \
            .format(escape(destination_file_name))
    return '<h1 style="margin:20px auto;width:800px;">File {} successfully created!</h1>'.format(escape(destination_file_name))


def upload_blob(bucket_name, destination_blob_name, content):
    """Uploads a file to the bucket."""

    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    blob.upload_from_string(content)
