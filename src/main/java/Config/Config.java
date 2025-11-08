
package Config;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Properties;

public class Config {

    private static final String CONFIG_DIR = System.getProperty("user.home") + "/.Culturarte";
    private static final String CONFIG_PATH = CONFIG_DIR + "/config.properties";
    private static final Config instance = new Config();

    private Properties props;

    private Config() {
        init();
    }

    private void init() {
        try {
            File dir = new File(CONFIG_DIR);
            File file = new File(CONFIG_PATH);

            if (!dir.exists()) {
                dir.mkdirs();
            }

            if (!file.exists()) {
                copiarDefault(file);
            }

            props = new Properties();
            try (InputStream in = Files.newInputStream(file.toPath())) {
                props.load(in);
            }

            System.out.println("Cliente configurado con: " + file.getAbsolutePath());

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void copiarDefault(File destino) throws IOException {
        try (InputStream in = getClass().getClassLoader().getResourceAsStream("config.properties")) {
            if (in == null)
                throw new IOException("No se encontró config.properties dentro del classpath del cliente");
            Files.copy(in, destino.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
    }

    public static Config getInstance() {
        return instance;
    }

    public String get(String key) {
        return props.getProperty(key);
    }
}
