from typing import List

import prefect
from prefect import Flow, task
from prefect.storage import GitHub

STORAGE = GitHub(
    repo="dyvenia/elt_workshop", path="elt_workshop/prefect/concat_files_sbx.py"
)


@task
def read_file(path: str) -> str:
    with open(path) as f:
        return f.read()


@task
def concat_files_and_diplay(file_contents: List[str]):

    logger = prefect.context.get("logger")

    concatenated = "".join(file_contents)
    logger.info(f"Concatenated text: {concatenated}")


with Flow("Concat files - sbx", storage=STORAGE) as flow:
    file_1 = read_file("file_1.txt")
    file_2 = read_file("file_2.txt")
    concatenated = concat_files_and_diplay(file_contents=[file_1, file_2])
