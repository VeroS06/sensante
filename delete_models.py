from huggingface_hub import HfApi

api = HfApi()
api.delete_file(
    path_in_repo="models",
    repo_id="verosylva06/sensante",
    repo_type="space",
    token=""
)
print("Done!")