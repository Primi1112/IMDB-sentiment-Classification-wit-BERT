FROM tensorflow/tensorflow
ENV model_name=bert

COPY models/ /app/models/

COPY requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

RUN python -c "exec(\"from transformers import BertTokenizer, TFBertForSequenceClassification\nTFBertForSequenceClassification.from_pretrained('bert-base-uncased')\")"

RUN python -c "exec(\"import nltk\nnltk.download('stopwords')\nnltk.download('punkt')\")"

COPY tokenzier.pkl /app/tokenzier.pkl

COPY app.py /app/app.py

WORKDIR /app

CMD python app.py