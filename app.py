from flask import Flask, render_template, url_for, request

app = Flask(__name__)


@app.route("/")
def hello_world():
    return '<p><a href="{url}">Hello</a>, World!</p>'.format(url=url_for("hello"))


@app.route("/hello/", methods=["GET", "POST"])
def hello():
    name = None
    if request.method == "POST":
        name = request.form["name"]
    return render_template("hello.html", name=name)
