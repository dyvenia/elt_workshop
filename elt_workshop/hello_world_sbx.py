from prefect import Flow, task
from prefect.run_configs import DockerRun
from prefect.storage import GitHub

ELT_WORKSHOP_REPO = "przemekdata49/elt_workshop"
STORAGE = GitHub(
    repo=ELT_WORKSHOP_REPO, path="elt_workshop/prefect/hello_world_sbx.py", ref="sbx"
)


@task
def echo(text: str) -> str:
    return text


with Flow(
    "Hello, world - sandbox", storage=STORAGE, run_config=DockerRun(labels=["sbx"])
) as flow:
    hello_world = echo("Hello, world!")
