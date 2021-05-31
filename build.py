#!/usr/bin/env python3

import argparse
import os
import subprocess

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("--img", type=str, required=True,
			help="Name of the docker builder image")
	parser.add_argument("--src", type=str, required=True,
			help="Path to checked out Chromium source tree")

	args = parser.parse_args()

	docker_img = args.img
	chromium_src_path = os.path.realpath(args.src)

	subprocess.call([ "docker", "run", "--rm",
			"-v", "{0}:/mnt/chromium".format(chromium_src_path),
			"--name", "chromium-builder",
			"-it", docker_img])

