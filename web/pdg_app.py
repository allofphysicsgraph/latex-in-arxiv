#!/usr/bin/env python3
# Ben Payne
# Physics Derivation Graph
# https://allofphysics.com
# Creative Commons Attribution 4.0 International License
# https://creativecommons.org/licenses/by/4.0/

from flask import Flask, render_template
import requests
import json

web_app = Flask(__name__, static_folder="static")
web_app.config["DEBUG"] = True

import base64


@web_app.template_filter("b64decode")
def b64decode(s):
    decoded_bytes = base64.b64decode(s)
    return decoded_bytes


@web_app.route("/", methods=["GET", "POST"])
def index():
    # https://flask.palletsprojects.com/en/stable/quickstart/#rendering-templates
    zoekt_ip = "10.10.10.20"
    r = requests.post(f"http://{zoekt_ip}:6070/api/search", '{"Q":"://"}')
    dct = json.loads(r.content)
    dct = dct["Result"]["Files"]
    return render_template("hello.html", names=dct)


if __name__ == "__main__":
    web_app.run(debug=True, host="0.0.0.0")

# EOF
