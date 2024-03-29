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

# Step 6: Syncing changes

If you make changes to the app code, you'll need to rebuild the image and recreate the container to see the changes.
To avoid this, you can use a bind mount to sync the code inside the container with the code on your local machine.

Run the image using the following command:

```bash
docker run --name <container-name> -p <local-port>:<container-port> -v $(pwd):/usr/src/app <image-name>
```

`-v $(pwd):/usr/src/app` tells Docker to sync the current directory on your local machine with the /usr/src/app directory inside the container.

You will have an error `"Cannot find module 'express'"` because the node_modules folder is not copied to the container. To fix this, you can add a volume for the node_modules folder.

Run the image using the following command:

```bash
docker run --name <container-name> -p <local-port>:<container-port> -v $(pwd):/usr/src/app -v /usr/src/app/node_modules <image-name>
```

-v /usr/src/app/node_modules tells Docker to create a volume for the node_modules folder inside the container. This will prevent the node_modules folder from being overwritten by the bind mount. It's called an anonymous volume.

When you make change, you still need to restart the container to see it.

To avoid restarting the container every time you make a change, you can use nodemon to automatically restart the app when changes are detected.

To do this, you need to install nodemon as a development dependency and use it to start the app in the Dockerfile.

Add the following line to the Dockerfile:

```Dockerfile
CMD ["npm", "run", "dev"]
```

This will start the app using the dev script in package.json, which should start the app using nodemon.

Then, rebuild the image and recreate the container to see the changes.

# Step 7: Build an image from another Dockerfile for development environment

We want to use nodemon only in development environment.
You can create a new Dockerfile for development environment, for example, Dockerfile.dev.

Then, build the image using the following command:

```bash
docker build -t <image-name>:<tag> -f Dockerfile.dev .
```

Replace `<image-name>` with the name and `<tag>` with the tag you want to give to your image. For example, `docker build -t my-image:dev -f Dockerfile.dev .` will create an image named `my-image` with tag `dev`.

# Step 8: Run the image for development environment

Run the image using the following command:

```bash
docker run --name <container-name> -p <local-port>:<container-port> -v $(pwd):/usr/src/app -v /usr/src/app/node_modules <image-name>
```

Now when you make changes to the app code, nodemon will automatically restart the app inside the container.

# Step 9: .dockerignore

To avoid copying unnecessary files and directories to the image, you can create a .dockerignore file in the same directory as the Dockerfile.

Add the following lines to the .dockerignore file:

```bash
node_modules
Dockerfile
Dockefile.dev
package-lock.json
```

This will prevent the node_modules folder, the Dockerfile, the Dockerfile.dev, and the package-lock.json file from being copied to the image.

# Accessing the container

To access the container, use the following command:

```bash
docker exec -it <container-name> sh
```
