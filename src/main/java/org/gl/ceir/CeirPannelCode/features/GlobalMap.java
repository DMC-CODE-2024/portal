package org.gl.ceir.CeirPannelCode.features;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class GlobalMap {

    public static Map<Integer, List<String>> globalMap = new HashMap<>();

    public static Map<Integer, List<String>> getInstance() {
        return globalMap;
    }

    public static void put(Integer key, List<String> value) {
        globalMap.put(key, value);
    }

    public static List<String> get(Integer key) {
        return globalMap.get(key);
    }

    public static void remove(Integer key) {
        globalMap.remove(key);
    }

    public static boolean containsKey(Integer key) {
        return globalMap.containsKey(key);
    }

    public void forEach() {
        globalMap.forEach((key, value) -> System.out.println("globalMap [" + key + ": " + value + "]"));
    }
}

