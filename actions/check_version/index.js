const core = require("@actions/core");
const github = require("@actions/github");
const { exec } = require("child_process");

try {
  let podspec = core.getInput("podspec");
  exec(`pod ipc spec ${podspec}`, function(err, stdout, stderr) {
    if (err) {
      core.setFailed(err);
    }
    const tagVersion = github.context.payload.release && github.context.payload.release.name;
    let packageVersion = "v" + JSON.parse(stdout).version;
    if (tagVersion !== packageVersion) {
      core.setFailed("Version is invalid");
    }
  });
} catch (e) {
  core.setFailed(e.message);
}
