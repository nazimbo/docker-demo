# Step 1: Build the image

Build the image using the following command:

```bash
docker build -t <image-name> .
```

Replace `<image-name>` with the name you want to give to your image. For example, `docker build -t my-image .` will create an image named `my-image`.

The dot at the end of the command is important. It tells Docker to look for the Dockerfile in the current directory.
If it was in a different directory, you would replace the dot with the path to the directory containing the Dockerfile, like this: `docker build -t my-image /path/to/Dockerfile`.

# Step 2: Run the image

Run the image using the following command:

```bash
docker run --name <container-name> <image-name>
```

Replace `<container-name>` with the name you want to give to your container. For example, `docker run --name my-container my-image` will create a container named `my-container` from the `my-image` image.

When you go to `http://localhost:3000` in your browser, you won't see anything. That's because the app is running inside the container, not on your local machine.

Your local machine and the container are two separate environments.

# Step 3: Port mapping
