from fastapi import FastAPI

app = FastAPI()
@app.get("/")

#def port 8080

def root():
    return {"message": "Hello World"}
