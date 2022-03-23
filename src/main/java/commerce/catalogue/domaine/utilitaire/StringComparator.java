package commerce.catalogue.domaine.utilitaire;

public class StringComparator {
    private StringComparator() {
    }

    public static boolean isEqualNoCase(String str1, String str2) {
        if (isNullEmptyOrBlank(str1)) {
            return isNullEmptyOrBlank(str2);
        } else {
            return isNullEmptyOrBlank(str2) ? isNullEmptyOrBlank(str1) : str1.toLowerCase().equals(str2.toLowerCase());
        }
    }

    public static boolean isAlike(String str1, String str2) {
        int len = Integer.min(str1 == null ? 0 : str1.length(), str2 == null ? 0 : str2.length());
        int threshold = (int)Math.round((double)((float)len) / 3.0D);
        if (threshold == 0) {
            threshold = 1;
        }

        return isAlike(str1, str2, threshold);
    }

    public static boolean isAlike(String str1, String str2, int levDistanceThreshold) {
        if (isNullEmptyOrBlank(str1)) {
            return isNullEmptyOrBlank(str2);
        } else if (isNullEmptyOrBlank(str2)) {
            return isNullEmptyOrBlank(str1);
        } else if (levDistanceThreshold <= 0) {
            throw new IllegalArgumentException("levDistanceThreshold cannot be lower or equal to 0 : " + levDistanceThreshold);
        } else {
            return computeLevenshteinDistance(str1.toLowerCase(), str2.toLowerCase()) <= levDistanceThreshold;
        }
    }

    private static boolean isNullEmptyOrBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private static int computeLevenshteinDistance(String str1, String str2) throws IllegalArgumentException {
        if (str1 != null && str2 != null) {
            int lenStr1 = str1.length();
            int lenStr2 = str2.length();
            int[] v0 = new int[lenStr2 + 1];
            int[] v1 = new int[lenStr2 + 1];

            int i;
            for(i = 0; i <= lenStr2; v0[i] = i++) {
            }

            for(i = 0; i < lenStr1; ++i) {
                v1[0] = i + 1;

                for(int j = 0; j < lenStr2; ++j) {
                    int deletionCost = v0[j + 1] + 1;
                    int insertionCost = v1[j] + 1;
                    int substitutionCost = str1.charAt(i) == str2.charAt(j) ? v0[j] : v0[j] + 1;
                    v1[j + 1] = Integer.min(Integer.min(deletionCost, insertionCost), substitutionCost);
                }

                int[] vSwap = v0;
                v0 = v1;
                v1 = vSwap;
            }

            return v0[lenStr2];
        } else {
            throw new IllegalArgumentException();
        }
    }
}