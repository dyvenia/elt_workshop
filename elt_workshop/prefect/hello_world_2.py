from prefect.storage import GitHub
from prefect.run_configs.docker import DockerRun
from prefect.utilities.notifications import slack_notifier
from prefect.schedules import Schedule
from prefect.schedules.clocks import CronClock
from prefect.engine.state import Failed
from prefect import Flow, task


STORAGE = GitHub(
    repo="dyvenia/elt_workshop", path="elt_workshop/prefect/hello_world_2.py"
)
RUN_CONFIG = DockerRun(
    image="prefecthq/prefect:0.15.11-python3.9",
    env={"HTTP_PROXY": "SOME_IP_ADDR"},
    labels=["dev"],
)
SLACK_NOTIFIER = slack_notifier(only_states=[Failed])
SCHEDULE = Schedule(clocks=[CronClock("*/5 * * * *")])


@task
def echo(text):
    return text


with Flow(
    "My first prod Prefect flow",
    storage=STORAGE,
    run_config=RUN_CONFIG,
    state_handlers=[SLACK_NOTIFIER],
    schedule=SCHEDULE,
) as flow:
    hello_world = echo("Hello, world!")
