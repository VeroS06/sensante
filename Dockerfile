FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install huggingface_hub

COPY . .

# Telecharger les modeles depuis Hugging Face
RUN python -c "
from huggingface_hub import hf_hub_download
import os
os.makedirs('models', exist_ok=True)
files = ['model.pkl', 'encoder_sexe.pkl', 'encoder_region.pkl', 'feature_cols.pkl']
for f in files:
    hf_hub_download(repo_id='verosylva06/sensante', filename=f'models/{f}', repo_type='space', local_dir='.')
    print(f'Downloaded {f}')
"

EXPOSE 8000

CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]