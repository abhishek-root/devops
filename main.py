"""Fastapi application for basic health & root endpoints"""

from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    """Return a welcome mesage"""
    return {"message": "Hello World from FastAPI"}

@app.get("/health")
def health_check():
    """return health status"""
    return {"status": "ok"}