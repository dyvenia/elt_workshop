from prefect import Flow, task
from prefect.engine.state import Failed
from prefect.run_configs.docker import DockerRun
from prefect.schedules import Schedule
from prefect.schedules.clocks import CronClock
from prefect.storage import GitHub
from prefect.utilities.notifications import slack_notifier

ELT_WORKSHOP_REPO = "dyvenia/elt_workshop"
STORAGE = GitHub(
    repo=ELT_WORKSHOP_REPO, path="elt_workshop/prefect/hello_world_dev_failing.py"
)
RUN_CONFIG = DockerRun(
    image="prefecthq/prefect:0.15.11-python3.9",
    env={"HTTP_PROXY": "SOME_IP_ADDR"},
    labels=["dev"],
)
SLACK_NOTIFIER = slack_notifier(only_states=[Failed])
SCHEDULE = Schedule(clocks=[CronClock("* */12 * * *")])


@task
def echo(text):
    return text

@task
def failing_task():
    raise ValueError


with Flow(
    "Hello, world - dev - failing",
    storage=STORAGE,
    run_config=RUN_CONFIG,
    state_handlers=[SLACK_NOTIFIER],
    schedule=SCHEDULE,
) as flow:
    hello_world = echo("Hello, world!")
    fail = failing_task()