FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl

RUN pip install fastapi[standard] uvicorn[standard]

EXPOSE 8000

COPY ./api /app

WORKDIR /app

# CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

CMD ["fastapi","dev","app.py"]
