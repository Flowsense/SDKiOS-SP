import subprocess

from argparse import ArgumentParser
from git import Repo


def git_push(repo_path: str, message: str, tag_name: str):
    repo = Repo(repo_path)
    repo.git.add('--all')
    repo.git.commit('-m', message)
    repo.git.tag(tag_name)

    origin = repo.remote(name='origin')
    origin.push(tag_name)


def update_file(version_code: str, checksum: str):
    original_file = open("Package.swift", "r")
    list_of_lines = original_file.readlines()

    list_of_lines[18] = f"            url: \"https://raw.githubusercontent.com/Flowsense/XCFrameworks_iOS/main/" \
                        f"frameworks/{version_code}.zip\",\n"
    list_of_lines[19] = f"            checksum: \"{checksum}\"\n"

    a_file = open("Package.swift", "w")
    a_file.writelines(list_of_lines)
    a_file.close()


def calculate_checksum(version_name: str):

    # swift package compute-checksum ../SDKFlowsenseiOS/build/FlowsenseSDK.xcframework.zip
    result = subprocess.run(['swift', 'package', 'compute-checksum',
                             f'../XCFrameworks_iOS/frameworks/{version_name}.zip'],
                            stdout=subprocess.PIPE)
    output = result.stdout.decode("utf-8")
    return output.strip()


def zip_xcframework(version_name: str):

    # ditto -c -k --sequesterRsrc --keepParent ../SDKFlowsenseiOS/build/FlowsenseSDK.xcframework \
    # ../XCFrameworks_iOS/frameworks/version_name.zip
    result = subprocess.run(['ditto', '-c', '-k', '--sequesterRsrc', '--keepParent',
                             '../SDKFlowsenseiOS/build/FlowsenseSDK.xcframework',
                             f'../XCFrameworks_iOS/frameworks/{version_name}.zip'],
                            stdout=subprocess.PIPE)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("-v", "--version", dest="version_code",
                        help="the version code for this release")

    args = parser.parse_args()
    version_code = args.version_code

    zip_xcframework(version_code)
    checksum = calculate_checksum(version_code)
    #git_push('../XCFrameworks_iOS', f'Update the SDK for version:{version_code}', version_code)

    update_file(version_code, checksum)
    #git_push('.',f'Update the SDK for version:{version_code}', version_code)