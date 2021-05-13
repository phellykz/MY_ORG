public class Teste20190204 {
    public static String[] ordenarDesc(List<String> listaValores) {
        //String[] listaOrdenadaDesc = new String[]{};
        List<String> listaOrdenadaDesc = new List<String>();
        if (listaValores != null && !listaValores.isEmpty()) {
            listaValores.sort();
            Integer ultIndex = listaValores.size() - 1;
            for (Integer i = ultIndex; i >= 0; i--) {
                listaOrdenadaDesc.add(listaValores.get(i));
            }
        }
        return listaOrdenadaDesc;
    }
    
    public static Integer[] ordenarDesc(List<Integer> listaValores) {
        //String[] listaOrdenadaDesc = new String[]{};
        List<Integer> listaOrdenadaDesc = new List<Integer>();
        if (listaValores != null && !listaValores.isEmpty()) {
            listaValores.sort();
            Integer ultIndex = listaValores.size() - 1;
            for (Integer i = ultIndex; i >= 0; i--) {
                listaOrdenadaDesc.add(listaValores.get(i));
            }
        }
        return listaOrdenadaDesc;
    }
    
    public static Map<String, String> ordenarMapaPorChaves(Map<String, String> mapa) {
        Map<String, String> mapaRetorno = new Map<String, String>();
        if (mapa != null && mapa.size() > 0) {
            //Set<String> chaves = mapa.keySet();
            List<String> listaChaves = new List<String>(mapa.keySet());
            //List<String> listaChaves = new List<String>();
            //listaChaves.addAll(mapa.keySet());
            listaChaves.sort();
            for (String chave : listaChaves) {
                String valor = mapa.get(chave);
                mapaRetorno.put(chave, valor);
            }            
        }
        return mapaRetorno;
    }
}