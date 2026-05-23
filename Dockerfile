FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install huggingface_hub

COPY . .

RUN python -c "from huggingface_hub import hf_hub_download; import os; os.makedirs('models', exist_ok=True); hf_hub_download(repo_id='verosylva06/sensante-mod\u00e8les', filename='mod\u00e8le.pkl', repo_type='dataset', local_dir='models/', token=None); hf_hub_download(repo_id='verosylva06/sensante-mod\u00e8les', filename='encoder_sexe.pkl', repo_type='dataset', local_dir='models/'); hf_hub_download(repo_id='verosylva06/sensante-mod\u00e8les', filename='encoder_region.pkl', repo_type='dataset', local_dir='models/'); hf_hub_download(repo_id='verosylva06/sensante-mod\u00e8les', filename='feature_cols.pkl', repo_type='dataset', local_dir='models/')"

EXPOSE 8000

CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]