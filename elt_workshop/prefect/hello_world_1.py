from prefect import Flow, task


@task
def echo(text):
    return text


with Flow(
    "My first Prefect flow",
) as flow:
    hello_world = echo("Hello, world!")
