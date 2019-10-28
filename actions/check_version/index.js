const core = require("@actions/core");
const github = require("@actions/github");
const { exec } = require("child_process");

try {
  let podFile = core.getInput("podFile");
  console.log(podFile);
  exec(`pod ipc spec ${podFile}`, function(err, stdout, stderr) {
    if (err) {
      core.setFailed(err);
    }
    const tagVersion = github.context.payload.release && github.context.payload.release.name;
    let packageVersion = "v" + JSON.parse(stdout).version;
    if (tagVersion !== packageVersion) {
      core.setFailed("Version is invalid");
    } else {
      core.setOutput("version", packageVersion);
    }
  });
} catch (e) {
  core.setFailed(e.message);
}
