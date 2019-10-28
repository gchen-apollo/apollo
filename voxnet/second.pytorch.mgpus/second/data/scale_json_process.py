import json as js
import urllib.request
from pathlib import Path
import os
import fire

def download_dataset(dataset_json_file, output_dir):
    with open(dataset_json_file) as json_file:
        infos = js.load(json_file)

    for info in infos:
        task_id = info['task_id']
        task_folder = Path(output_dir) / task_id
        task_folder.mkdir(parents=True, exist_ok=True)
        anno_link = info['response']['annotations']['url']
        anno_file = task_folder / "annotations.json"
        if not os.path.isfile(anno_file):
            urllib.request.urlretrieve(anno_link, anno_file)
        for link in info['params']['attachments']:
            print("%s: %s" %(task_id, os.path.basename(link)))
            file = task_folder / os.path.basename(link)
            if not os.path.isfile(file):
                urllib.request.urlretrieve(link, file)



if __name__ == '__main__':
    fire.Fire()