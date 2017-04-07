#!/usr/bin/python

from pprint import pprint

def fild_all_files(directory):
    import os
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file == "usage.json":
                yield os.path.join(root, file)

class MyList(list):
    def get(self, index, default=None):
        return self[index] if len(self) > index else default

def main():
    import json
    app_screen = "5031"
    count = MyList([0, 0, 0, 0])
    for path in fild_all_files("../log/"):
        # print path
        with open(path) as fp:
            for item in json.load(fp)["usage"]:
                if item["app_screen"] == app_screen:
                    pprint(item)
                    count[int(item["app_item"]) - 1] += item["count"]

    print json.dumps({"summary": [{"product_id": 0, "app_item":"{0:02d}".format(i+1), "app_screen": app_screen, "count":count.get(i)} for i in range(20)]})


if __name__ == "__main__":
    main()
