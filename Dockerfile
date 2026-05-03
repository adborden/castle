FROM python:3.14
LABEL org.opencontainers.image.source=https://github.com/adborden/castle

#RUN apt-get update \
#  && apt-get install \
#  uv \
#  && rm -rf /var/apt/lists/*

ENV POETRY_CACHE_DIR=/root/.cache/pypoetry
ENV PIP_CACHE_DIR=/root/.cache/pip
RUN --mount=type=cache,dst=${POETRY_CACHE_DIR} \
  --mount=type=cache,dst=${PIP_CACHE_DIR} \
  pip install -U poetry && poetry --version

WORKDIR /app
COPY pyproject.toml poetry.lock /app/
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
RUN --mount=type=cache,dst=${POETRY_CACHE_DIR} \
  --mount=type=cache,dst=${PIP_CACHE_DIR} \
  poetry install

ENV ANSIBLE_PULL_REPOSITORY=https://github.com/adborden/castle.git
ENV ANSIBLE_PULL_REF=main
ENV ANSIBLE_PULL_PLAYBOOK=site.yaml
ENV PATH=/app/.venv/bin:$PATH

COPY docker/run.sh /usr/local/bin/
CMD ["run.sh"]
