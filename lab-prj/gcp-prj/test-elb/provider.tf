

# provider "google-beta" {
#   project     = "my-project-id"
#   region      = "us-central1"
#   zone        = "us-central1-c"
# }

provider "google" {
  # credentials = file("credentials_techx.json")
  alias = "gcp-techx"
  access_token = "ya29.a0AeTM1iemLEFlnqaQxqAtiDWHs88SJ19YCurx-b7zD4U4yqOrQHi0LPcMv7hURGaTET0IaMqIK4ALPPg-lFGpHfH0mvkuUslf0tjli8Kk7fVKd7Nu940LqqaRGuh3HBwaT3vjAQ9KNYhvURLxLY5KhTerUcmVPIEtXivUaCgYKAWkSARESFQHWtWOmhR0h3SPtEJR_JsAz3sjPcg0171"
  # credentials = file("credentials_lab.json")
  # credentials_lab = file("credentials_lab.json")
  # access_token = "ya29.a0Aa4xrXNEw41EegHSyFmOgHWc46lRMVEz9Xp4V8Igs3itTu8atogrS6oyUlnKS-oC7Jcbv9uNX_9LZMKTtrXaujNEdHxOZNbkpwVlU0x-LertQhioSuyu-7zDV5f1QzdGI72mjC8SY7IJ_PAgJynPv4WWyxij59FXlaktaCgYKATASARISFQEjDvL9PSZIxrTgw_-PF3-BefHa4w0171"
  project     = "scbtechx-sharedvpc-nonprod"
  # project = "lab2-360510"
  region      = "asia-southeast1"
  zone        = "asia-southeast1-b"
}
provider "google" {
  # credentials = file("credentials_techx.json")
  alias = "gcp-pex"
  access_token = "ya29.a0AeTM1ifZvTgV7wdgKwmfBdD9b_7MMgoNYNgANITY4I2YZ0edgKdpLuIa5sihkALj1Np36dZ401-Kbq4_c0NeErbkb4KRZT47Xt5CHbXj-p4YZFbtku2pWKCn-XaNO3DuFsDNDdDfhX2w1eop61eEYFRIse-Q7MnF3WVSaCgYKAbESARESFQHWtWOmngUCzWNG38V4tYtOZY4Zqg0171"
  # credentials = file("credentials_lab.json")
  # credentials_lab = file("credentials_lab.json")
  # access_token = "ya29.a0Aa4xrXNEw41EegHSyFmOgHWc46lRMVEz9Xp4V8Igs3itTu8atogrS6oyUlnKS-oC7Jcbv9uNX_9LZMKTtrXaujNEdHxOZNbkpwVlU0x-LertQhioSuyu-7zDV5f1QzdGI72mjC8SY7IJ_PAgJynPv4WWyxij59FXlaktaCgYKATASARISFQEjDvL9PSZIxrTgw_-PF3-BefHa4w0171"
  project     = "pex-nonprod"
  # project = "lab2-360510"
  region      = "asia-southeast1"
  zone        = "asia-southeast1-b"
}
# gcloud auth print-access-token