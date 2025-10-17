from fastapi import FastAPI
from datetime import datetime

app = FastAPI(title="ChatApp Onion - Beta")

@app.get("/health")
async def health():
    return {"status": "ok", "time": datetime.utcnow().isoformat()}
