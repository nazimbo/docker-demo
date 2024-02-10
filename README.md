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

To see the app in your browser, you need to map the port inside the container to a port on your local machine.

Run the image using the following command:

```bash
docker run --name <container-name> -p <local-port>:<container-port> <image-name>
```

Replace `<local-port>` with the port you want to use on your local machine. For example, `docker run --name my-container -p 4000:3000 my-image` will create a container named `my-container` from the `my-image` image and map port 4000 on your local machine to port 3000 inside the container.

Now when you go to `http://localhost:4000` in your browser, you should see the app.

# Step 4: Stop the container

To stop the container, use the following command:

```bash
docker stop <container-name>
```

You can get the container name by running `docker ps`.

# Step 5: Remove the container

To remove the container, use the following command:

```bash
docker rm <container-name>
```

For both below commands, you can specify more than one container name. For example, `docker stop my-container my-other-container` will stop both `my-container` and `my-other-container`.
