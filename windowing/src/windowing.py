import numpy as np
import matplotlib.pyplot as plt
from scipy.signal.windows import tukey

################ NEED TO BE UPDATED ################
fs   = 200_000.0
T    = 0.02
tukey_alpha = 0.35
eps_db = 1e-12
################ NEED TO BE UPDATED ################

N = int(round(T * fs))
t = np.arange(N) / fs

# --- windows ---
win_rect  = np.ones(N, dtype=np.float64)
win_hann  = np.hanning(N)
win_tukey = tukey(N, alpha=tukey_alpha)

windows = [
    ("Rectangular", win_rect),
    ("Hann", win_hann),
    (f"Tukey (α={tukey_alpha})", win_tukey),
]

def fft_db_norm(w, fs_hz, nfft=None):
    if nfft is None:
        nfft = len(w)
    X = np.fft.rfft(w, n=nfft)
    freqs = np.fft.rfftfreq(nfft, d=1/fs_hz)
    mag = np.abs(X) / len(w)
    mag_db = 20*np.log10(mag + eps_db)
    mag_db -= mag_db.max()  # peak 0 dB
    return freqs, mag_db

nfft = 8 * N  # zero-pad for smoother spectrum

for name, w in windows:
    freqs, mag_db = fft_db_norm(w, fs, nfft=nfft)

    plt.figure(figsize=(10, 6))

    # --- Time domain subplot ---
    plt.subplot(2, 1, 1)
    plt.plot(t * 1e3, w)
    plt.title(f"Time Domain - {name} Window")
    plt.xlabel("Time [ms]")
    plt.ylabel("Amplitude")
    plt.grid(True)

    # --- FFT subplot ---
    plt.subplot(2, 1, 2)
    plt.plot(freqs, mag_db)
    plt.title(f"FFT (dB, normalized) - {name} Window")
    plt.xlabel("Frequency [Hz]")
    plt.ylabel("Magnitude [dB]")
    plt.grid(True)

    # DC çevresini görmek için zoom
    plt.xlim(0, 3000)
    plt.ylim(-120, 5)

    plt.tight_layout()
    plt.show()
