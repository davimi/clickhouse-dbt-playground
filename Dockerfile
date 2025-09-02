FROM python:3.11-slim-bookworm

# Upgrade system, install utilities
RUN apt-get update \
  && apt-get upgrade -y --no-install-recommends \
  && apt-get install -y --no-install-recommends \
      curl jq net-tools openssh-client procps sudo

# Install Poetry
RUN pip install --no-cache-dir --upgrade poetry==2.1.4

# Create dbt_user user
RUN groupadd --gid 1000 dbt_user \
    && useradd --create-home --uid 1000 --gid 1000 dbt_user \
    && echo dbt_user ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/dbt_user \
    && chmod 0440 /etc/sudoers.d/dbt_user

# Ensure dbt_user user can run docker
RUN groupadd docker \
    && adduser dbt_user docker

USER dbt_user

# Install Python dependencies
WORKDIR /home/dbt_user
ENV POETRY_VIRTUALENVS_IN_PROJECT 0
ENV POETRY_VIRTUALENVS_PATH /home/dbt_user/venvs
COPY pyproject.toml poetry.lock ./
RUN poetry install --sync


COPY --chown=dbt_user dbt_project.yml ./
COPY --chown=dbt_user profiles.yml ./
COPY --chown=dbt_user selectors.yml ./
COPY --chown=dbt_user models models

USER dbt_user

