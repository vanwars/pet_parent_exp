from contextlib import asynccontextmanager

from app.routers import tasks, users, breeds
from app.utils import get_session

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles


@asynccontextmanager
async def lifespan(app: FastAPI):
    # creates DB session session when the application starts
    print("lifespan start...")
    session = await get_session()

    yield

    # closes session when the application stops
    print("lifespan end...")
    await session.close()


app = FastAPI(lifespan=lifespan)
app.include_router(tasks.router)
app.include_router(users.router)
app.include_router(breeds.router)


app.mount("/", StaticFiles(directory="ui", html=True), name="ui")
