from huggingface_hub import HfApi

api = HfApi()
token = ""
repo_id = "verosylva06/sensante"

# Supprimer les fichiers mal placés à la racine
for f in ["model.pkl", "encoder_sexe.pkl", "encoder_region.pkl", "feature_cols.pkl"]:
    try:
        api.delete_file(path_in_repo=f, repo_id=repo_id, repo_type="space", token=token)
        print(f"Deleted {f}")
    except:
        print(f"Could not delete {f}")

# Uploader dans le bon dossier models/
files = [
    ("models/model.pkl", "models/model.pkl"),
    ("models/encoder_sexe.pkl", "models/encoder_sexe.pkl"),
    ("models/encoder_region.pkl", "models/encoder_region.pkl"),
    ("models/feature_cols.pkl", "models/feature_cols.pkl")
]

for local_path, repo_path in files:
    api.upload_file(
        path_or_fileobj=local_path,
        path_in_repo=repo_path,
        repo_id=repo_id,
        repo_type="space",
        token=token
    )
    print(f"Uploaded {repo_path}")

print("All done!")