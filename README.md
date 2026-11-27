# AI Solution Development Project

## Running the EDA notebook in Docker

Build the image (from this folder):

```sh
docker build -t machine-eda .
```

**Open it in JupyterLab** at <http://localhost:8888>:

```sh
docker run --rm -p 127.0.0.1:8888:8888 machine-eda
```

Changes made inside the container are lost when it stops. To edit the real
`eda.ipynb` on your machine instead, mount the folder (PowerShell: use `${PWD}`):

```sh
docker run --rm -p 127.0.0.1:8888:8888 -v "$(pwd):/app" machine-eda
```

**Run it headless** and save the executed notebook to `output/eda.ipynb`:

```sh
docker run --rm -v "$(pwd)/output:/app/output" machine-eda \
  jupyter nbconvert --to notebook --execute eda.ipynb --output-dir output
```

Add `--to html` instead of `--to notebook` for a readable HTML report.
