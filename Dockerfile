FROM python:3.9
WORKDIR /app
ENV PYTHONUNBUFFERED=1

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

ENTRYPOINT [ "python3" ]

CMD [ "rjchecker.py"]