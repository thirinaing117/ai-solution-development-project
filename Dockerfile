# Container for the EDA notebook (eda.ipynb).
# The notebook was written on Python 3.13, so the image uses the same version.
FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# Install the pinned EDA libraries first so this layer is cached
# when only the notebook or data change.
COPY requirements.txt .
RUN pip install -r requirements.txt \
    && pip install jupyterlab nbconvert

# Run as a non-root user.
RUN useradd --create-home --uid 1000 analyst
COPY --chown=analyst:analyst eda.ipynb ./
COPY --chown=analyst:analyst data/ ./data/
RUN mkdir -p output && chown analyst:analyst output
USER analyst

EXPOSE 8888

# Default: open the notebook in JupyterLab at http://localhost:8888
# (no token, so only publish the port on your own machine).
# To run it headless instead, see README.md.
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", \
     "--ServerApp.token=", "--ServerApp.password=", "--notebook-dir=/app"]
