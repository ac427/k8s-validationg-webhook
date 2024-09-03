FROM debian:bookworm-slim  AS build-env

WORKDIR /app
RUN apt-get update && apt-get install -y python3 python3-venv 
RUN  python3 -m venv /app
RUN /app/bin/pip install requests flask
COPY stats.py .
COPY app.py .


FROM gcr.io/distroless/python3-debian12
COPY --from=build-env /app /app
WORKDIR /app
ENTRYPOINT ["/app/bin/python3", "app.py"]
