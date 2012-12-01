# -*- coding: utf-8 -*-
"""Installer for this package."""

from setuptools import setup
from setuptools import find_packages

import os

# shamlessly stolen from Hexagon IT guys
def read(*rnames):
    return open(os.path.join(os.path.dirname(__file__), *rnames)).read()

version = '0.1dev'

setup(name='ethertest',
      version=version,
      description="Testing bed for ip networks",
      long_description=read('README.md')+read("LICENSE"),
      classifiers=[
        "Programming Language :: Python",
        ],
      keywords='testing bed network ip tcp udp firewall',
      author='Jaka Hudoklin',
      author_email='jakahudoklin@gmail.com',
      url='https://github.com/offlinehacker/ethertest',
      license='MIT',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      dependency_links =
            ["https://github.com/jwiegley/scapy/tarball/master#egg=scapy-2.1.1-dev"],
      install_requires=[
          # list project dependencies
          'scapy',
          'pyx',
          'gnuplot-py',
          'numpy',
          'nose',
          'sphinx',
          'fabric',
          'cuisine',
          'pyyaml'
      ],
      test_suite="ethertest.tests"
)
