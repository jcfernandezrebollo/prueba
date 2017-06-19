package urjc.tfg.flamegraphpipelineplugin;

import java.io.IOException;

import hudson.EnvVars;
import hudson.Extension;
import hudson.model.Action;
import hudson.model.Run;
import hudson.model.TaskListener;
import hudson.model.listeners.RunListener;

@Extension
public class Graphic extends RunListener<Run> {
	

    public Graphic() {
        super(Run.class);
    }

	@Override
    public void onCompleted(Run build, TaskListener listener) {
		int number = build.number;
		EnvVars env;
		String name = "";
		try {
			env = build.getEnvironment(listener);
			name = env.get("JOB_NAME")+"-"+env.get("BUILD_NUMBER");
		} catch (IOException | InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    	GraphicAction flameGraph = new GraphicAction(name);
    	build.getActions().add((Action) flameGraph);
    }

}

