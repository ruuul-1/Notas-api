FROM python:3.12-slim AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

FROM base AS test
RUN pip install -r requirements-dev.txt
CMD ["pytest", "-v"]

FROM base AS dev
EXPOSE 5000
CMD ["flask", "--app", "run", "run", "--debug"]

FROM base AS production
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "run:app"]