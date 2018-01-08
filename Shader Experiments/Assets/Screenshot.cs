using UnityEngine;
using System.Collections;

public class Screenshot : MonoBehaviour 
{    
    public enum EncodeType
    {
        PNG,
        JPG,
    }

    Camera m_Camera;
    string m_SavePath;
    public EncodeType m_EncodeType = EncodeType.PNG;

    int m_ShotNumber = 0;
    public float m_Scaler = 1;

    bool m_RenderAtEndOfFrame = false;

    public bool m_AllowManualScreencap = false;
    

    void Start()
    {
        m_ShotNumber =  PlayerPrefs.GetInt("shotnumber");
        m_Camera =      GetComponent<Camera>();
        m_SavePath =    Application.dataPath + "/"+  Application.productName + m_ShotNumber;
    }

    void OnApplicationQuit()
    {
        PlayerPrefs.SetInt("shotnumber", m_ShotNumber);
    }

    void Update()
    {
        
        if (m_AllowManualScreencap && Input.GetKeyDown(KeyCode.S))
        {
            ScreenShotPNG(Application.dataPath , m_Camera, true);
        }
    }

    public string ScreenShotPNG(string path, Camera cam, bool AddDatTime)
    {
        m_Camera = cam;

        if (AddDatTime)
            m_SavePath = path + m_Camera.name + " " + (Screen.width * m_Scaler) + "x" + (Screen.height * m_Scaler) + " " + System.DateTime.Now.ToString("dddd MMM dd yyyy HH_mm_ss") + System.DateTime.Now.Millisecond.ToString() + ".png";
        else
            m_SavePath = path + ".png";
        
        m_EncodeType = EncodeType.PNG;
        m_RenderAtEndOfFrame = true;

        return m_SavePath;
    }

    public string ScreenShotPNG(string path)
    {
        return ScreenShotPNG( path, m_Camera, false);
    }

    public Texture CaptureAndReturnPNG(string path)
    {
        return LoadScreenFromPath(ScreenShotPNG(path, m_Camera, false));
    }

    public string ScreenShotJPG(string path, Camera cam)
    {
        m_Camera = cam;
        m_SavePath = path + m_Camera.name + " " + (Screen.width * m_Scaler) + "x" + (Screen.height * m_Scaler) + " " + System.DateTime.Now.ToString("dddd MMM dd yyyy HH_mm_ss") + System.DateTime.Now.Millisecond.ToString() + ".jpg";
        m_EncodeType = EncodeType.JPG;
        m_RenderAtEndOfFrame = true;

        return m_SavePath;
    }

    public string ScreenShotJPG(string path)
    {
        return ScreenShotJPG(path, m_Camera);
    }

    void LateUpdate()
    {        
        if (m_RenderAtEndOfFrame)
        {
            m_RenderAtEndOfFrame = false;            

            int rw = (int)Mathf.Round(Screen.width * m_Scaler);
            int rh = (int)Mathf.Round(Screen.height * m_Scaler);
            RenderTexture rt = new RenderTexture(rw, rh, 24);
            m_Camera.targetTexture = rt;
            Texture2D ss = new Texture2D(rw, rh, TextureFormat.RGB24, false);

            //float a = Mcamera.aspect;
            //Mcamera.aspect = rw / rh;
            m_Camera.Render();
            RenderTexture.active = rt;
            ss.ReadPixels(new Rect(0, 0, rw, rh), 0, 0);
            m_Camera.targetTexture = null;
            RenderTexture.active = null;
           // Mcamera.aspect = a;

            m_Camera.ResetAspect();

            // Encode to image type
             byte[] bytes;
             if (m_EncodeType == EncodeType.JPG)
                 bytes = ss.EncodeToJPG(100);
             else
                 bytes = ss.EncodeToPNG();

            // Write file to disk
             System.IO.File.WriteAllBytes(m_SavePath, bytes);
             Debug.Log(string.Format("Took screenshot to: {0}", m_SavePath));

            // Clean up objects to avoid memory leak
            Destroy(rt);
            DestroyObject(ss);

            m_ShotNumber++;

            //gameObject.SetActive(false);
        }
    }

    public Texture LoadScreenFromPath(string fullPath)
    {
        Texture newTex;

        try
        {
            // Use WWW to load the file and try parse to a texture
            WWW newWWWW = new WWW("file://" + fullPath);
            newTex = newWWWW.texture;            

            return newTex;
        }
        catch
        {
            print("Cannot load: " + fullPath);
            return null;
        }
    }
}
