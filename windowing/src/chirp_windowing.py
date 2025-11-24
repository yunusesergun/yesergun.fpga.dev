import numpy as np
import matplotlib.pyplot as plt

from scipy.signal.windows import tukey


################ NEED TO BE UPDATED ################
# --- PARAMETERS ---
HFM  = 0 # 0=LFM, 1=HFM

fs   = 200_000.0   # Sampling frequency
T    = 0.02        # Chirp duration
f0   = 20_000.0    # Start frequency
f1   = 30_000.0    # End frequency
bits = 32          # Bit number

# Windoing parameters
tukey_alpha = 0.35

# spectrogram parameters
nperseg     = 1024
noverlap    = 896     # ~%75 overlap
eps_db      = 1e-12  # dB log için epsilon
################ NEED TO BE UPDATED ################


# FFT function
def compute_fft(sig, fs_hz):
    X = np.fft.rfft(sig)
    freqs = np.fft.rfftfreq(len(sig), d=1/fs_hz)
    mag = np.abs(X) / len(sig)
    return freqs, mag


# HFM function
def generate_hfm_chirp(fs_hz    : float,
                       T_s      : float,
                       f0_hz    : float,
                       f1_hz    : float,
                       bits     : int   = 16,
                       amplitude: float = 0.95):
    """
    Generates an HFM (Hyperbolic Frequency Modulated) chirp and quantizes it to integers.
    """
    assert 8 <= bits <= 32, "Bits must be between 8 and 32"

    N = int(round(T_s * fs_hz))
    t = np.arange(N, dtype=np.float64) / fs_hz

    # HFM phase
    phase = (f0_hz * f1_hz * T_s / (f1_hz - f0_hz)) * np.log(
        f1_hz * T_s / (f1_hz * T_s - (f1_hz - f0_hz) * t)
    )
    phase = 2.0 * np.pi * phase

    max_int = (1 << (bits - 1)) - 1
    dtype = np.int16 if bits <= 16 else np.int32

    x = amplitude * np.sin(phase)
    out = np.round(np.clip(x, -1.0, 1.0) * max_int).astype(dtype)

    return out, t


# LFM function
def generate_lfm_chirp(fs_hz    : float,
                       T_s      : float,
                       f0_hz    : float,
                       f1_hz    : float,
                       bits     : int   = 16,
                       amplitude: float = 0.95):
    """
    Generates an LFM (Linear Frequency Modulated) chirp and quantizes it to integers.
    """
    assert 8 <= bits <= 32, "Bits must be between 8 and 32"

    k = (f1_hz - f0_hz) / T_s

    N = int(round(T_s * fs_hz))
    t = np.arange(N, dtype=np.float64) / fs_hz

    # LFM fazı
    phase = 2.0 * np.pi * (f0_hz * t + 0.5 * k * t**2)

    max_int = (1 << (bits - 1)) - 1
    dtype = np.int16 if bits <= 16 else np.int32

    x = amplitude * np.sin(phase)
    out = np.round(np.clip(x, -1.0, 1.0) * max_int).astype(dtype)

    return out, t


# --- Generate Chirp ---
if (HFM == 1):
    y_int, t = generate_hfm_chirp(fs, T, f0, f1_hz=f1, bits=bits, amplitude=0.95)
else:
    y_int, t = generate_lfm_chirp(fs, T, f0, f1_hz=f1, bits=bits, amplitude=0.95)

# Normalize for visualization
y = y_int.astype(np.float64) / ((1 << (bits - 1)) - 1)

# ---------------- WINDOWING ----------------
N = len(y)

win_rect  = np.ones(N, dtype=np.float64)         # "no window" == Rectangle
win_hann  = np.hanning(N)                        # Hann windowing
win_tukey = tukey(N, alpha=tukey_alpha)          # Tukey windowing


# --------------- WINDOWING PLOT --------------- #
plt.figure(figsize=(10, 8))

plt.subplot(3, 1, 1)
plt.plot(t * 1e3, win_rect)
plt.title("Time Domain (Rectangle Window)")
plt.xlabel("Time [ms]")
plt.ylabel("Amplitude")
plt.grid(True)

plt.subplot(3, 1, 2)
plt.plot(t * 1e3, win_hann)
plt.title("Time Domain (Hann Window)")
plt.xlabel("Time [ms]")
plt.ylabel("Amplitude")
plt.grid(True)

plt.subplot(3, 1, 3)
plt.plot(t * 1e3, win_tukey)
plt.title("Time Domain (Tukey Window)")
plt.xlabel("Time [ms]")
plt.ylabel("Amplitude")
plt.grid(True)

plt.tight_layout()
plt.show()
# --------------- WINDOWING PLOT --------------- #


# Windowing
y_rect  = y * win_rect
y_hann  = y * win_hann
y_tukey = y * win_tukey


# --------------- TIME-DOMAIN PLOT --------------- #
plt.figure(figsize=(10, 8))

plt.subplot(3, 1, 1)
plt.plot(t * 1e3, y_rect, lw=0.8)
plt.title("Time Domain")
plt.xlabel("Time [ms]")
plt.ylabel("Amplitude")
plt.grid(True)

plt.subplot(3, 1, 2)
plt.plot(t * 1e3, y_hann, lw=0.8)
plt.title("Time Domain - Hann Window")
plt.xlabel("Time [ms]")
plt.ylabel("Amplitude")
plt.grid(True)

plt.subplot(3, 1, 3)
plt.plot(t * 1e3, y_tukey, lw=0.8)
plt.title(f"Time Domain - Tukey Window (alpha={tukey_alpha})")
plt.xlabel("Time [ms]")
plt.ylabel("Amplitude")
plt.grid(True)

plt.tight_layout()
plt.show()
# --------------- TIME-DOMAIN PLOT --------------- #


# FFT Computation
freq_rect,  mag_rect  = compute_fft(y_rect,  fs)
freq_hann,  mag_hann  = compute_fft(y_hann,  fs)
freq_tukey, mag_tukey = compute_fft(y_tukey, fs)

f_low, f_high = 0, fs / 2


# --------------- FFT (MAGNITUDE) PLOT --------------- #
plt.figure(figsize=(10, 8))

plt.subplot(3, 1, 1)
plt.plot(freq_rect, mag_rect)
plt.title("FFT")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Amplitude")
plt.grid(True)
plt.xlim(f_low, f_high)

plt.subplot(3, 1, 2)
plt.plot(freq_hann, mag_hann)
plt.title("FFT - Hann Window")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Amplitude")
plt.grid(True)
plt.xlim(f_low, f_high)

plt.subplot(3, 1, 3)
plt.plot(freq_tukey, mag_tukey)
plt.title(f"FFT - Tukey Window (alpha={tukey_alpha})")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Amplitude")
plt.grid(True)
plt.xlim(f_low, f_high)

plt.tight_layout()
plt.show()
# --------------- FFT (MAGNITUDE) PLOT --------------- #


# FFT Computation (dB)
mag_rect_db  = 20 * np.log10(mag_rect  + eps_db)
mag_hann_db  = 20 * np.log10(mag_hann  + eps_db)
mag_tukey_db = 20 * np.log10(mag_tukey + eps_db)


# --------------- FFT (dB) PLOT --------------- #
plt.figure(figsize=(10, 8))

plt.subplot(3, 1, 1)
plt.plot(freq_rect, mag_rect_db)
plt.title("FFT (dB)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude [dB]")
plt.grid(True)
plt.xlim(f_low, f_high)
plt.ylim(-140, 0)

plt.subplot(3, 1, 2)
plt.plot(freq_hann, mag_hann_db)
plt.title("FFT (dB) - Hann Window")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude [dB]")
plt.grid(True)
plt.xlim(f_low, f_high)
plt.ylim(-220, 0)

plt.subplot(3, 1, 3)
plt.plot(freq_tukey, mag_tukey_db)
plt.title(f"FFT (dB) - Tukey Window (alpha={tukey_alpha})")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude [dB]")
plt.grid(True)
plt.xlim(f_low, f_high)
plt.ylim(-220, 0)

plt.tight_layout()
plt.show()
# --------------- FFT (dB) PLOT --------------- #


# ---------------- Spectrogram ----------------
win_boxcar_seg = np.ones(nperseg, dtype=float)
win_hann_seg   = np.hanning(nperseg)
win_tukey_seg  = tukey(nperseg, alpha=tukey_alpha)

spec_items = [
    ("Spectrogram (Rectangle)", win_boxcar_seg),
    ("Spectrogram (Hann)", win_hann_seg),
    (f"Spectrogram (Tukey) (α={tukey_alpha})", win_tukey_seg),
]


plt.figure(figsize=(10, 8))

for i, (title, win_arr) in enumerate(spec_items, start=1):
    plt.subplot(3, 1, i)
    Pxx, freqs_s, bins_s, im = plt.specgram(
        x=y,
        NFFT=nperseg,
        Fs=fs,
        noverlap=noverlap,
        window=win_arr,
        mode='magnitude'
    )
    plt.ylim(0, fs/2)
    plt.xlabel("Time [ms]")
    plt.ylabel("Frequency [Hz]")
    plt.title(title)
    cbar = plt.colorbar(im, pad=0.01)
    cbar.set_label("Magnitude")

plt.tight_layout()
plt.show()
