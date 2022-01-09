from prefect import Flow, task
from prefect.storage import GitHub


@task
def echo(text):
    return text


STORAGE = GitHub(
    repo="dyvenia/elt_workshop", path="elt_workshop/prefect/hello_world_1.py"
)


with Flow("My first Prefect flow", storage=STORAGE) as flow:
    hello_world = echo("Hello, world!")
