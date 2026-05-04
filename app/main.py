from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session

from app.db import Note, get_db, init_db

app = FastAPI(title="Notes API")


class NoteIn(BaseModel):
    title: str
    body: str = ""


class NoteOut(NoteIn):
    id: int

    class Config:
        from_attributes = True


@app.on_event("startup")
def on_startup():
    init_db()


@app.get("/health")
def health():
    return {"status": "ok", "version": "v3"}


@app.post("/notes", response_model=NoteOut)
def create_note(note: NoteIn, db: Session = Depends(get_db)):
    n = Note(title=note.title, body=note.body)
    db.add(n)
    db.commit()
    db.refresh(n)
    return n


@app.get("/notes", response_model=list[NoteOut])
def list_notes(db: Session = Depends(get_db)):
    return db.query(Note).all()


@app.get("/notes/{note_id}", response_model=NoteOut)
def get_note(note_id: int, db: Session = Depends(get_db)):
    n = db.query(Note).get(note_id)
    if not n:
        raise HTTPException(404, "not found")
    return n


@app.delete("/notes/{note_id}")
def delete_note(note_id: int, db: Session = Depends(get_db)):
    n = db.query(Note).get(note_id)
    if not n:
        raise HTTPException(404, "not found")
    db.delete(n)
    db.commit()
    return {"deleted": note_id}
