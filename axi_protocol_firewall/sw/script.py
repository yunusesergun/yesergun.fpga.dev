# Add package: Vitis Python CLI
import vitis
import os
import shutil

ws_dir_name = "vitis_workspace"

if os.path.exists(ws_dir_name):
    shutil.rmtree(ws_dir_name)

os.makedirs(ws_dir_name)

# Create a Vitis client object
client = vitis.create_client()

# Set Vitis Workspace
client.set_workspace(path=ws_dir_name)

# Defining names for platform, application_component and
plat_name="platform_ublaze"
comp_name="app_ublaze"

# Create and build platform component
platform_obj=client.create_platform_component(name=plat_name, hw_design="./design_1_wrapper.xsa", cpu="microblaze_0", os="standalone")
platform_obj.build()

# This returns the platform xpfm path
platform_xpfm=client.find_platform_in_repos(plat_name)

# Create and build application component
comp = client.create_app_component(name=comp_name, platform = platform_xpfm, domain = "standalone_microblaze_0")
comp.import_files(from_loc='./src', dest_dir_in_cmp='./src')

platform_obj.build()
comp.build()

vitis.dispose()
