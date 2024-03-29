#create a simple flask application docker
FROM python:3.7-alpine
WORKDIR /app
COPY ./tests/ /app
RUN pip install flask
EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]