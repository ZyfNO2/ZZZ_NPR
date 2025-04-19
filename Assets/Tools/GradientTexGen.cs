using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
#endif

using System.IO;
using System.Collections;

namespace mattatz.Utils {

    public class GradientTexGen {

        public static Texture2D Create (Gradient grad, int width = 32, int height = 1) {
            var gradTex = new Texture2D(width, height, TextureFormat.ARGB32, false);
            gradTex.filterMode = FilterMode.Bilinear;
            float inv = 1f / (width - 1);
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    var t = x * inv;
                    Color col = grad.Evaluate(t);
                    gradTex.SetPixel(x, y, col);
                }
            }
            gradTex.Apply();
            return gradTex;
        }

    }

    #if UNITY_EDITOR
    public class GradientTexCreator : EditorWindow {

        [SerializeField] Gradient gradient;
        [SerializeField] int width = 128;
        [SerializeField] int height = 16;
        [SerializeField] string fileName = "Gradient";
        [SerializeField] private bool autoSave = false;
        [SerializeField] Texture2D gradientMap;

        [MenuItem("ArtTools/Gradient贴图生成工具")]
		    static void Init() {
			      EditorWindow.GetWindow(typeof(GradientTexCreator));
		    }

            void OnValidate()
            {
                if (autoSave)
                {
                
                    gradientMap = EditorGUILayout.ObjectField("gradient Map", gradientMap, typeof(Texture2D)) as Texture2D;
                    if(gradientMap == null) return;

                    string path = AssetDatabase.GetAssetPath(gradientMap);
                    //Debug.Log("path is " + path);
                    var tex = GradientTexGen.Create(gradient, width, height);

                    if (path.EndsWith(".tga"))
                    {
                        //tga
                        byte[] pngData = tex.EncodeToTGA();
                        File.WriteAllBytes(path  , pngData);
                    }
                    else if(path.EndsWith(".png"))
                    {
                        //png
                        byte[] pngData = tex.EncodeToPNG();
                        File.WriteAllBytes(path , pngData);
                    }
                    else
                    {
                        Debug.LogError("The texture format is not png or tga,plase use those format");
                    }
                
                    AssetDatabase.Refresh();
                }
            }

        void OnGUI () {
            EditorGUI.BeginChangeCheck();
            SerializedObject so = new SerializedObject(this);
            EditorGUILayout.PropertyField(so.FindProperty("gradient"), true, null);
            if (EditorGUI.EndChangeCheck()) {
                so.ApplyModifiedProperties();
            }

            using (new GUILayout.HorizontalScope()) {
                GUILayout.Label("width", GUILayout.Width(80f));
                int.TryParse(GUILayout.TextField(width.ToString(), GUILayout.Width(120f)), out width);
            }

            using (new GUILayout.HorizontalScope()) {
                GUILayout.Label("height", GUILayout.Width(80f));
                int.TryParse(GUILayout.TextField(height.ToString(), GUILayout.Width(120f)), out height);
            }

            using (new GUILayout.HorizontalScope())
            {
                GUILayout.Label("auto save", GUILayout.Width(80f));
                autoSave = GUILayout.Toggle(autoSave,"");
            }

            

            if (!autoSave)
            {
                using (new GUILayout.HorizontalScope()) {
                    GUILayout.Label("name", GUILayout.Width(80f));
                    fileName = GUILayout.TextField(fileName, GUILayout.Width(120f));
                    GUILayout.Label(".png");
                }
                
                if(GUILayout.Button("Save")) {
                    string path = EditorUtility.SaveFolderPanel("Select an output path", "", "");
                    if(path.Length > 0) {
                        var tex = GradientTexGen.Create(gradient, width, height);
                        byte[] pngData = tex.EncodeToPNG();
                        File.WriteAllBytes(path + "/" + fileName + ".png", pngData);
                        AssetDatabase.Refresh();
                    }
                }
            }
           
        }
    }
    #endif
}